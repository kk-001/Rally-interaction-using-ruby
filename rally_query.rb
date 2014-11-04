#FUNCTION FOR QUERYING RALLY
#---------------------------
def query_rally(query_type, query_fetch, query_project, query_project_scope, query_string_attribute, query_string_value)

  new_query = RallyAPI::RallyQuery.new()
  
  #query type is always a symbol. So we convert the string fro mthe calling function into a symbol
  new_query.type = "#{query_type}".to_sym   

  #query fetch can be true(gets all values)/a string that specifies specific objects to get
  new_query.fetch = ""
  if query_fetch.is_a?(TrueClass) || query_fetch.is_a?(FalseClass)
   new_query.fetch = query_fetch
  else
   new_query.fetch = "\"#{query_fetch}\""
  end


  #query project is not a mandatory parameter in all commands
  if query_project!=nil
   new_query.project = query_project
   new_query.project_scope_up = query_project_scope

    if query_string_attribute == nil
      query_result = @rally.find(new_query)
      return query_result

    else
      new_query.query_string = "(#{query_string_attribute} = \"#{query_string_value}\")"
      query_result = @rally.find(new_query)
      return query_result
    end

  else

    if query_string_attribute == nil
      query_result = @rally.find(new_query)
      return query_result

    else
      new_query.query_string = "(#{query_string_attribute} = \"#{query_string_value}\")"
      query_result = @rally.find(new_query)
      return query_result
    end

  end

end



 #QUERYING FOR A PROJECT
 #----------------------
 result = query_rally("project", true, nil, true, "query_string_attribute", "query_string_value")
 test_set_pj = result.first()
 
#QUERYING FOR RELEASE
#--------------------
 result = query_rally("release", true, test_set_pj, false, "Name", test_set_release)
 required_release = result.first()


#QUERYING FOR AN ITERATION
#-------------------------
 result = query_rally("iteration", true, test_set_pj, false, "Name", test_set_iteration)
 required_iteration = result.first()


#QUERY AND GET ALL TEST FOLDERS UNDER A PROJECT
#----------------------------------------------
 tf_result = query_rally("test_folder", true, test_folder_pj, false, nil, nil)


#QUERY AND GET ALL TEST SETS UNDER AN ITERATION
#---------------------------------------------
 pr_ts_result = query_rally("test_set", true, test_set_pj, false, "Iteration.Name", required_iteration)


