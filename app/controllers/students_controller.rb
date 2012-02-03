class StudentsController < ApplicationController
        def index
               if !params[:sort].nil?
                      sort = params[:sort]
                else
                        sort = "id"
                end
                if !params[:sorten].nil?
                        @sorten=params[:sorten]
                        if params[:sorten] == "Asc"
                                @sorten_list = "Desc"
                        else
                                @sorten_list = "Asc"
                        end
                else
                        @sorten = "Asc"
                        @sorten_list = "Desc"
                end
                @students = Student.paginate :page => params[:page], :per_page => 5, :order=>"students.#{sort} #{@sorten}"
        end
        def new
                @student=Student.new
        end
        def create
               @student =Student.new(params[:student])
               if !params[:hobbies].nil?
               @student.hobbies = params[:hobbies].join(",")
                end
                if @student.first_name.blank? && @student.last_name.blank? && @student.dob.nil? && @student.marital_status.blank? && @student.gender.nil?
                        @error="All fields must be entered <ul><li> first name</li>  <li>last name</li> <li> dob</li>  <li>gender</li> <li> marital status</li></ul>"
                elsif @student.first_name.strip.blank?
                        @error="first name should not be left blank "
                elsif @student.first_name.match(/([a-zA-Z])/).nil?
                        @error="First name string only"
                elsif @student.last_name.strip.blank?
                        @error="last name should not be left blank"
                elsif @student.last_name.match(/^[a-zA-Z]/).nil?
                        @error="last name string only"
                elsif @student.dob.nil?
                        @error="date of birth must be entered"
                elsif @student.gender.nil?
                        @error="gender has to be there"
                elsif @student.marital_status.strip.blank?
                        @error="marital_status is nil.., make it fill"
                end

                 render :update do |page|
                        if !@error.nil?
                                 page.replace_html 'listing', :partial => 'err_message'
                         else
                                  @student.save
                                @students = Student.paginate :page => params[:page] || 1, :per_page => 5
                                page.replace_html 'listing', :partial => 'listing'
                         end
                end
        end
        def show
                @student=Student.find(params[:id])
        end
        def edit
                @student=Student.find(params[:id])
        end
        def update
                @student=Student.find(params[:id])
                if !params[:hobbies].nil?
                        @student.hobbies = params[:hobbies].join(",")
                else
                        @student.hobbies = ""
                end
                 @student.update_attributes(params[:student])
                redirect_to "/students"
        end
        def newone
                @student=Student.new
                 render :update do |page|
                        page.replace_html 'newrecord', :partial => 'record'
                end
        end
        def search_record
                @students=Student.find(:all, :conditions=> ["first_name like ?","%#{params[:search]}%"])
                 render :update do |page|
                        page.replace_html 'listing', :partial => 'filtering'
                end
        end
end

