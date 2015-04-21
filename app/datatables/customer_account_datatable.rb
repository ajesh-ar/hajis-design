class CustomerAccountDatatable < AjaxDatatablesRails::Base

  # uncomment the appropriate paginator module,
  # depending on gems available in your project.
  include AjaxDatatablesRails::Extensions::Kaminari
  # include AjaxDatatablesRails::Extensions::WillPaginate
  # include AjaxDatatablesRails::Extensions::SimplePaginator

  def sortable_columns
    # Declare strings in this format: ModelName.column_name
    @sortable_columns ||= []
  end

  def searchable_columns
    # Declare strings in this format: ModelName.column_name
    @searchable_columns ||= []
  end

  private

  def data
    records.map do |record|
      [
        record.customer.email,
        record.amount,
        record.balance_amount,
        record.date,
        "<a href='javascript:void(0);' onClick='editCustomerAccounts(#{record.id});'>Edit</a>"
      ]
    end
  end

  def get_raw_records
    CustomerAccount.includes(:customer)
  end

  # ==== Insert 'presenter'-like methods below if necessary
end
