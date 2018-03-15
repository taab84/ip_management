class ReceiptsController < ApplicationController
  before_action :set_receipt, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /receipts
  # GET /receipts.json
  def index
    if receipt_type
      @receipts = receipt_type.all
    else
      redirect_to root_url
    end
  end

  # GET /receipts/1
  # GET /receipts/1.json
  def show
    if receipt_type
      @receipt = Receipt.find(params[:id])
      respond_to do |format|
        format.html
        format.pdf do
        pdf = ReceiptPdf.new(@receipt)
        send_data pdf.render,
          filename: "receipt_#{@receipt.serie}_#{@receipt.number}",
          type: 'application/pdf',
          disposition: 'inline'
    end
      end
    else
      redirect_to root_url
    end
  end

  # GET /receipts/new
  def new
    @receipt = receipt_type.new
  end

  # GET /receipts/1/edit
  def edit
  end

  # POST /receipts
  # POST /receipts.json
  def create
    @receipt = receipt_type.new(receipt_params)
    @receipt.user_id = current_user.id
    respond_to do |format|
      if @receipt.save!
        format.html { redirect_to @receipt, notice: 'Receipt was successfully created.' }
        format.json { render :show, status: :created, location: @receipt }
      else
        format.html { render :new }
        format.json { render json: @receipt.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /receipts/1
  # PATCH/PUT /receipts/1.json
  def update
    respond_to do |format|
      if @receipt.update(receipt_params)
        format.html { redirect_to @receipt, notice: 'Receipt was successfully updated.' }
        format.json { render :show, status: :ok, location: @receipt }
      else
        format.html { render :edit }
        format.json { render json: @receipt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /receipts/1
  # DELETE /receipts/1.json
  def destroy
    @receipt.destroy!
    respond_to do |format|
      format.html { redirect_to customized_url, notice: 'Receipt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def customized_url
      "/" + params[:type].tableize if params[:type].in? receipt_types
    end

    def receipt_types
      ["Receipt", "MarkReceipt", "IdenticalSearchReceipt", "SimilarSearchReceipt"]
    end

    def receipt_type
      params[:type].constantize if params[:type].in? receipt_types
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_receipt
      @receipt = Receipt.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def receipt_params
      params.require(:mark_receipt).permit(:owner_name, :type, :owner_adress, :representative_id, :owner_street, :owner_wilaya, :mark_name, :image,
      :mark_type, :colored, :classes, :rev_pri, :ipas_num, :order_ids => [])
      # if params[:type] == "MarkReceipt" 
      # end
    end
end
