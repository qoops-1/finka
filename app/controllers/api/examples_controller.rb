class Api::ExamplesController < Api::BaseController
  before_action :find_example, only: [:show, :update, :destroy]

  def index
    render json: Example.all
  end

  def show
    render json: @example
  end

  def create
    example = Example.new example_params
    if example.save
      render json: example
    else
      render json: { errors: example.errors }, status: :unprocessable_entity
    end
  end

  def update
    if @example.update_attributes example_params
      render json: @example
    else
      render json: { errors: @example.errors }, status: :unprocessable_entity
    end
  end

  def destroy
    @example.destroy
    render json: :ok
  end

  private

  def find_example
    @example = Example.find(params[:id]) if params[:id]
  end

  def example_params
    params.permit(:content)
  end
end