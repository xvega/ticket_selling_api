module Pagination
   extend ActiveSupport::Concern

    def pagination_meta(object, extra_meta = {})
     {
       current_page: object.current_page,
       next_page:    object.next_page,
       prev_page:    object.prev_page,
       total_pages:  object.total_pages,
       total_count:  object.total_count
     }.merge(extra_meta)
   end
end
