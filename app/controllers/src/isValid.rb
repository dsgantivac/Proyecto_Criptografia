def isValid()
   if !current_user
     redirect_to '/users/new', notice: "debes inicias sesion"
   end
end
