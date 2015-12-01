class TimetablesController < ApplicationController
  before_action :set_timetable, only: [:show, :edit, :update, :destroy]
  before_filter :search_employee

  # GET /timetables
  # GET /timetables.json
  def index
    @timetables = @employee.timetables
  end

  # GET /timetables/1
  # GET /timetables/1.json
  def show
    @timetables = @employee.timetable.find params[:id]
  end

  # GET /timetables/new
  def new
    @timetable = @employee.timetables.build
  end

  # GET /timetables/1/edit
  def edit
  end

  # POST /timetables
  # POST /timetables.json
  def create
    @timetable = @employee.timetables.build(timetable_params)

    respond_to do |format|
      if @timetable.save
        format.html { redirect_to employee_timetables_path, notice: 'Timetable was successfully created.' }
        format.json { render :show, status: :created, location: @timetable }
      else
        format.html { render :new }
        format.json { render json: @timetable.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /timetables/1
  # PATCH/PUT /timetables/1.json
  def update
    @timetable = @employee.timetables.find(params[:id])
    respond_to do |format|
      if @timetable.update(timetable_params)
        format.html { redirect_to employee_timetables_path, notice: 'Timetable was successfully updated.' }
        format.json { render :show, status: :ok, location: @timetable }
      else
        format.html { render :edit }
        format.json { render json: @timetable.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /timetables/1
  # DELETE /timetables/1.json
  def destroy
    @timetable.destroy
    respond_to do |format|
      format.html { redirect_to employee_timetables_path, notice: 'Timetable was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_timetable
    @timetable = Timetable.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def timetable_params
    params.require(:timetable).permit(:date, :slot1, :slot2, :slot3, :slot4, :employee_id)
  end

  def search_employee
    @employee = Employee.find(params[:employee_id])
  end
end
