module ApplicationHelper
  def edit_and_destroy_buttons(item)
    return if current_user.nil?

    edit = link_to('Edit', url_for([:edit, item]), class: "btn btn-primary btn-sm")
    del = button_to('Remove', item, method: :delete,
                                    form: { data: { turbo_confirm: "Are you sure ?" } },
                                    class: "btn btn-danger btn-sm")
    raw("#{edit}#{del}")
  end

  def round(num)
    number_with_precision(num, precision: 1)
  end
end
