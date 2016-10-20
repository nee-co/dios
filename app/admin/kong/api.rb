ActiveAdmin.register_page 'Kong' do

  action_item :new, only: :index do
    link_to "New API", admin_kong_new_path
  end

  page_action :new, method: :get
  page_action :edit, method: :get
  page_action :create, method: :post
  page_action :update, method: :put
  page_action :destroy, method: :delete

  controller do
    layout 'active_admin'

    def index
      @api = Kong::Api.all
    end

    def new
      @api = ::Form::Kong::Api.new
    end

    def create
      @api = ::Form::Kong::Api.new(form_params)
      if @api.valid?
        @api.create
        redirect_to admin_kong_path
      else
        render :new
      end
    end

    def edit
      @api = fetch_api
    end

    def update
      @api = ::Form::Kong::Api.new(form_params)
      if @api.valid?
        @api.update
        redirect_to admin_kong_path
      else
        render :edit
      end
    end

    def destroy
      ::Kong::Api.delete(params[:name])
      redirect_to admin_kong_path
    end

    private

    def form_params
      params.require(:form_kong_api).permit(::Form::Kong::Api::PERMITTED_ATTRIBUTES, plugins: [])
    end

    def fetch_api
      api = ::Kong::Api.find(params[:name])
      ::Form::Kong::Api.new(api.to_hash
                               .merge(plugins: api.plugins.map(&:name))
                               .symbolize_keys
                               .slice(*::Form::Kong::Api::PERMITTED_ATTRIBUTES))
    end
  end
end
