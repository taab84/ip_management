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
      # @receipt = receipt_type.find(params[:id])
      respond_to do |format|
        format.html
        format.pdf do
          @payements = @receipt.payements
          pdf = ReceiptPdf.new(@receipt, @payements)
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
      @receipt.group_id = current_user.group.id
      respond_to do |format|
        if @receipt.valid?
          @receipt.setting_op
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
    # Use callbacks to share common setup or constraints between actions.
    def set_receipt
      @receipt = receipt_type.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def receipt_params
      if params[:type] == "MarkReceipt" then
        params.require(:mark_receipt).permit(:owner_name, :type, :owner_adress, :representative_id, :owner_street, :owner_wilaya, :mark_name, :image,
      :mark_type, :colored, :classes, :rev_pri, :ipas_num, :order_ids => [])
      elsif params[:type] == "IdenticalSearchReceipt" then params.require(:identical_search_receipt).permit(:owner_name, :type, :owner_adress, :representative_id, :owner_street, :owner_wilaya, :image,
        :number_searches, :number_classes, :order_ids => [])
      elsif params[:type] == "SimilarSearchReceipt" then params.require(:similar_search_receipt).permit(:owner_name, :type, :owner_adress, :representative_id, :owner_street, :owner_wilaya, :image,
        :number_searches, :number_classes, :order_ids => [])
      elsif params[:type] == "RectificationMarkReceipt" then params.require(:rectification_mark_receipt).permit(:owner_name, :type, :owner_adress, :representative_id, :owner_street, :owner_wilaya, :image,
        :number_marks, :order_ids => [])
      end
    end

    def customized_url
      "/" + params[:type].tableize if params[:type].in? receipt_types
    end

    def receipt_type
      params[:type].constantize if params[:type].in? receipt_types
    end

    def receipt_types
      ["Receipt", "MarkReceipt", "IdenticalSearchReceipt", "SimilarSearchReceipt", "RectificationMarkReceipt"]
    end

end
