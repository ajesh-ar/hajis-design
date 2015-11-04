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
    records.map do |record|
      [
        (record.customer.name rescue 'Not entered'),
        record.amount,
        record.balance_amount,
        (record.date ? record.date.strftime('%d/%m/%Y') : nil),
        "<a href='javascript:void(0);' onClick='editCustomerAccounts(#{record.id});'>Edit</a>"
      ]
    end
  end

  def get_raw_records
    CustomerAccount.includes(:customer).scoped
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
