class SessionsController < ApplicationController
  def create
    @session = UserSession.new
    if using_open_id?
      open_id_authentication(params[:openid_identifier])
    else
      password_authentication(params[:name], params[:password])
    end
  end

  def new
    @session = UserSession.new
  end

  def destroy
    current_session.destroy
    redirect_to new_session_url
  end


   protected
     def password_authentication(name, password)
       if @current_user = @account.users.authenticate(params[:name], params[:password])
         successful_login
       else
         failed_login "Sorry, that username/password doesn't work"
       end
     end

     def open_id_authentication(identity_url)
       # Pass optional :required and :optional keys to specify what sreg fields you want.
       # Be sure to yield registration, a third argument in the #authenticate_with_open_id block.
       authenticate_with_open_id(identity_url,
           :required => [ ],
           :optional => [ :nickname, :email, :fullname ]) do |result, identity_url, registration|
         case result.status
         when :missing
           failed_login "Sorry, the OpenID server couldn't be found"
         when :invalid
           failed_login "Sorry, but this does not appear to be a valid OpenID"
         when :canceled
           failed_login "OpenID verification was canceled"
         when :failed
           failed_login "Sorry, the OpenID verification failed"
         when :successful
           if User.find_by_identity_url(identity_url)
             assign_registration_attributes!(registration)

             if current_user.save
               successful_login "Welcome back"
             else
               failed_login "Your OpenID profile registration failed: " +
                 @current_user.errors.full_messages.to_sentence
             end
           else
	     @current_user = User.new(:identity_url => identity_url)
             assign_registration_attributes!(registration)
	     
             if current_user.save
               successful_login "New account created"
             else
               failed_login "Your OpenID profile registration failed: " +
                 @current_user.errors.full_messages.to_sentence
             end
           end
         end
       end
     end

     # registration is a hash containing the valid sreg keys given above
     # use this to map them to fields of your user model
     def assign_registration_attributes!(registration)
       model_to_registration_mapping.each do |model_attribute, registration_attribute|
         unless registration[registration_attribute].blank?
           @current_user.send("#{model_attribute}=", registration[registration_attribute])
         end
       end
     end

     def model_to_registration_mapping
       { :login => 'nickname', :email => 'email', :display_name => 'fullname' }
     end 


   private
     def successful_login(message="Successful login")
       flash[:notice] = message
       session[:user_id] = @current_user.id
       session.save
       redirect_to(root_url)
     end

     def failed_login(message)
       flash[:error] = message
       redirect_to(new_session_url)
     end
end

