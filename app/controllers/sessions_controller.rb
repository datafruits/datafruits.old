class SessionsController < Devise::SessionsController
  def create
    logger.info "CREATE" 
    resource = warden.authenticate!(:scope => resource_name, :recall => :failure)
    return sign_in_and_redirect(resource_name, resource)
  end
  
  def sign_in_and_redirect(resource_or_scope, resource=nil)
    scope = Devise::Mapping.find_scope!(resource_or_scope)
    resource ||= resource_or_scope
    sign_in(scope, resource) unless warden.user(scope) == resource
    logger.info "signed in"
    respond_to do |format|
      format.html {
        set_flash_message(:notice, :signed_in) if is_navigational_format?
        respond_with resource, :location => after_sign_in_path_for(resource)
      }
      format.json {
        logger.info "about to render json"
        render :json => {:success => true, :redirect => stored_location_for(scope) || after_sign_in_path_for(resource)}
      }
    end
  end
 
  def failure
    respond_to do |format|
      format.html {
        respond_with resource, :location => after_sign_in_path_for(resource)
      }
      format.json {
        render :json => {:success => false, :errors => ["Login failed."]}
      }
    end
  end
end