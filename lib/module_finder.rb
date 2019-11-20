# frozen_string_literal: true

# Object in charge of finding a prefix
class ModuleFinder
  class << self
    def dig(routes)
      find_scope_of_route(routes.instance_variable_get('@scope'))
    end

    def find_scope_of_route(route)
      found = route&.instance_variable_get('@hash')&.try(:[], :module)
      return found if found

      route = route.instance_variable_get('@parent')
      if route
        find_scope_of_route(route)
      else
        ''
      end
    end
  end
end
