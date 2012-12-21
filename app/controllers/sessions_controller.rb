class SessionsController < Devise::SessionsController

	def create
		puts "===CREATE"
		resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#failure")
		p "========================="
		puts resource.inspect
		p "========================="
		sign_in_and_redirect(resource_name, resource)
	end

	def sign_in_and_redirect(resource_or_scope, resource=nil)
		puts "== SIGN IN"
    scope = Devise::Mapping.find_scope!(resource_or_scope)
    resource ||= resource_or_scope
    res = sign_in(scope, resource) unless warden.user(scope) == resource
		p "========================="
		puts scope.inspect
		p "-----------------------"
		puts resource.inspect
		p "-----------------------"
		puts res.inspect
		p "========================="
    return render :json => {:success => true, :redirect => stored_location_for(scope) || after_sign_in_path_for(resource)}
  end

	def failure
		return render :json => {:success => false, :errors => ["Login failed."]}
	end
end
