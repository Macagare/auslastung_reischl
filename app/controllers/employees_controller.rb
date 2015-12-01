class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update, :destroy, :book_employee]

  # GET /employees
  # GET /employees.json
  def index
    @employees = Employee.all
  end

  # GET /employees/1
  # GET /employees/1.json
  def show
  end

  # GET /employees/new
  def new
    @employee = Employee.new
    @employee.timetables.build
  end

  # GET /employees/1/edit
  def edit
  end

  # POST /employees
  # POST /employees.json
  def create
    @employee = Employee.new(employee_params)

    respond_to do |format|
      if @employee.save
        create_timetables
        format.html { redirect_to @employee, notice: 'Employee was successfully created.' }
        format.json { render :show, status: :created, location: @employee }
      else
        format.html { render :new }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employees/1
  # PATCH/PUT /employees/1.json
  def update
  end

  # DELETE /employees/1
  # DELETE /employees/1.json
  def destroy
    @employee.destroy
    respond_to do |format|
      format.html { redirect_to employees_url, notice: 'Employee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def book
    @employees = Employee.all
  end

  def book_employee
    respond_to do |format|
      if booking_valide?
        format.html { redirect_to @employee, notice: 'Employee was successfully booked.' }
        format.json { render :show, status: :created, location: @employee }
      else
        format.html { redirect_to @employee, notice: 'Employee is not available.' }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def booking_valide?
    filterd_employee = @employee.timetables.date_between(params[:start_date], params[:end_date])
    filterd_employee.map do |col|
      col[:slot1] && col[:slot2] && col[:slot3] && col[:slot4]
    end.count(false) >= 1
  end

  def set_employee
    @employee = Employee.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def employee_params
    params.require(:employee).permit(:name)
  end

  def create_timetables
    dates = Date.today..Date.today + 500
    ActiveRecord::Base.transaction do
      dates.each do |d|
        @employee.timetables.create(date: d)
      end
    end
  end
end
