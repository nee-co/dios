ActiveAdmin.register Aldea::Event do
  menu parent: 'Aldea'

  decorate_with Aldea::EventDecorator

  actions :all, except: %i(new create)

  permit_params :title, :body, :owner_id, :start_date, :is_public

  config.sort_order = 'start_date_asc'

  controller do
    def scoped_collection
      Aldea::Event.includes([:owner, :entries])
    end
  end

  index title: 'Event' do
    selectable_column
    id_column
    column :title
    column :owner
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
      row :owner
      row :start_date
      row :is_public
      row :image
      row :created_at
      row :updated_at
    end

    panel 'Event Entries' do
      table_for aldea_event.entries do
        column :user
      end
    end

    panel 'Event Comment' do
      table_for aldea_event.comments do
        column :user
        column :body
        column :posted_at
      end
    end

    active_admin_comments
  end

  form do |f|
    f.semantic_errors(*f.object.errors.keys)
    inputs 'Event' do
      input :title, required: true
      input :body, required: true
      input :owner_id, required: true
      input :start_date, as: :datepicker, datepicker_options: { min_date: DateTime.now }
      input :is_public, required: true
    end
    actions
  end
end
