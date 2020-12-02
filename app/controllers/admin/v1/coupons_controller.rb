module Admin::V1
  class CouponsController < ApiController
    before_action :load_coupon, only: [:update, :destroy]

    def index
      @loading_service = Admin::ModelLoadingService.new(Coupon.all, searchable_params)
      @loading_service.call
    end

    def create
      @coupon = Coupon.new
      @coupon.attributes = coupon_params
      save_coupon!
    end

    def update
      @coupon.attributes = coupon_params
      save_coupon!
    end    

    def destroy
      @coupon.destroy!
    rescue
      render_error(fields: @coupon.errors.messages)
    end       

    private

    def searchable_params
      params.permit({ search: :name }, { order: {} }, :page, :length)
    end
    
    def load_coupon
      @coupon = Coupon.find(params[:id])
    end

    def coupon_params
      return {} unless params.has_key?(:coupon)
      params.require(:coupon).permit(:name, :code, :status, :discount_value, :max_use, :due_date)
    end

    def save_coupon!
      @coupon.save!
      render :show
    rescue
      render_error(fields: @coupon.errors.messages)
    end    
  end
end
