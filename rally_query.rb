#FUNCTION FOR QUERYING RALLY
#---------------------------
def query_rally(query_type, query_fetch, query_project, query_project_scope, query_string_attribute, query_string_value)

  new_query = RallyAPI::RallyQuery.new()
  new_query.type = "#{query_type}".to_sym

  new_query.fetch = ""
  if query_fetch.is_a?(TrueClass) || query_fetch.is_a?(FalseClass)
   new_query.fetch = query_fetch
  else
   new_query.fetch = "#{query_fetch}"
  end


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
