class ImportConfigsController < ApplicationController
  before_action :set_import_config, only: %i[ show edit update destroy ]

  # GET /import_configs or /import_configs.json
  def index
    @import_configs = ImportConfig.all
  end

  # GET /import_configs/1 or /import_configs/1.json
  def show
  end

  # GET /import_configs/new
  def new
    @import_config = ImportConfig.new
  end

  # GET /import_configs/1/edit
  def edit
  end

  # POST /import_configs or /import_configs.json
  def create
    @import_config = ImportConfig.new(import_config_params)

    respond_to do |format|
      if @import_config.save
        format.html { redirect_to import_config_url(@import_config), notice: "Import config was successfully created." }
        format.json { render :show, status: :created, location: @import_config }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @import_config.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /import_configs/1 or /import_configs/1.json
  def update
    respond_to do |format|
      if @import_config.update(import_config_params)
        format.html { redirect_to import_config_url(@import_config), notice: "Import config was successfully updated." }
        format.json { render :show, status: :ok, location: @import_config }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @import_config.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /import_configs/1 or /import_configs/1.json
  def destroy
    @import_config.destroy!

    respond_to do |format|
      format.html { redirect_to import_configs_url, notice: "Import config was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_import_config
      @import_config = ImportConfig.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def import_config_params
      params.require(:import_config).permit(:asset_id, :config)
    end
end
