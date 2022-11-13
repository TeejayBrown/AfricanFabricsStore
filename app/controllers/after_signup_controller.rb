class AfterSignupController < ApplicationController
  include Wicked::Wizard
  # steps :profile, :avatar, :finish
  # Asterisk means variable number of arguments
  steps(*Customer.form_steps)

  def show
    @customer = current_customer

    case step
    when 'sign_up'
      skip_step if @customer.persisted?
    when 'set_address'
      @address = get_address
    end

    render_wizard
  end

  def update
    @customer = current_customer
    case step
    when 'set_name'
      if @customer.update(onboarding_params(step))
        render_wizard @customer
      # else
      #   render_wizard @customer status: :unprocessable_entity
      end
    when 'set_address'
      if @customer.create_address(onboarding_params(step).except(:form_step))
        render_wizard @customer
      else
        @address.destroy
        render_wizard @customer, status: :unprocessable_entity
      end
    end
  end

  private

  def get_address
    if @customer.address.nil?
      Address.new
    else
      @customer.address
    end
  end

  def finish_wizard_path
    root_path
  end

  def onboarding_params(step = 'sign_up')
    permitted_attributes = case step
                           when 'set_name'
                             required_parameters = :customer
                             %i[first_name last_name]
                           when 'set_address'
                             required_parameters = :address
                             %i[street city postal_code province_id]
                           end
    params.require(required_parameters).permit(:id, permitted_attributes).merge(form_step: step)
  end
end