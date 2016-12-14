ActiveAdmin.register Event do
  decorate_with EventDecorator

  actions :all

  permit_params :title, :body, :owner_id, :start_date, :is_public, :image

  config.sort_order = 'start_date_asc'

  index title: 'Event' do
    id_column
    column :title
    column(:owner) do |event|
      link_to event.owner_name, admin_user_path(event.owner_id)
    end
    column :start_date
    column :is_public
    column :image
    column :entry_count do |event|
      "#{event.entries.size}人"
    end
    actions
  end

  filter :id
  filter :title
  filter :owner_id
  filter :start_date
  filter :is_public

  show do
    attributes_table do
      row :id
      row :title
      row :body
      row(:owner) do |event|
        link_to event.owner_name, admin_user_path(event.owner_id)
      end
      row :start_date
      row :is_public
      row :image
      row :created_at
      row :updated_at
    end

    panel "Event Entries" do
      table_for event.entries.map(&:user) do
        column(:user) do |user|
          link_to user.name, admin_user_path(user.id)
        end
      end
    end

    panel "Event Comment" do
      table_for event.comments do
        column(:user) do |comment|
          link_to comment.user_name, admin_user_path(comment.user_id)
        end
        column :body
        column :posted_at
      end
    end

    active_admin_comments
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    inputs 'Event' do
      input :title, required: true
      input :body, required: true
      input :owner_id, required: true
      input :start_date, as: :datepicker, datepicker_options: { min_date: DateTime.now }
      input :is_public, required: true
      input :image, required: true
    end
    actions
  end
end
