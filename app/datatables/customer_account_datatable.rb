class CustomerAccountDatatable < AjaxDatatablesRails::Base

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= [
      'CustomerAccount.customer_id',
      'CustomerAccount.amount',
      'CustomerAccount.balance_amount',
      'CustomerAccount.date'
    ]
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= [
      'Customer.name',
      'CustomerAccount.amount',
      'CustomerAccount.balance_amount',
      'CustomerAccount.date'
    ]
  end

  private

  def data
    result = []
    records.group_by(&:date).each do |date, data|
      data.map do |record|
        result << [
          (record.date ? record.date.strftime('%d/%m/%Y') : nil),
          (record.customer.name rescue 'Not entered'),
          record.vehicle_boxes,
          record.vehicle_kg.to_f,
          record.rate.to_f,
          record.feed_amount.to_f,
          record.calculated_amount.to_f,
          record.amount.to_f,
          record.balance_amount.to_f,
          (record.old_balance.to_f + record.customer.current_balance.to_f),
          (record.old_balance.to_f + record.customer.current_balance.to_f + record.balance_amount.to_f),
          (record.total_paid.to_f + record.amount.to_f),
          (record.total.to_f + record.calculated_amount.to_f + record.customer.current_balance.to_f),
          "<a href='javascript:void(0);' onClick='editCustomerAccounts(#{record.id});'>Edit</a>"
        ]
      end
    end
    result
  end

  def get_raw_records
    CustomerAccount.includes(:customer).scoped
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
