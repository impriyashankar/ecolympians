if @membership.persisted?
  json.form json.partial!("memberships/form.html.erb", group: @group, membership: Membership.new)
  json.inserted_item json.partial!("groups/membership.html.erb", membership: @membership)
else
  json.form json.partial!("memberships/form.html.erb", group: @group, membership: @membership)
end
