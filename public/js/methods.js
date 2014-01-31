$(function() {

	$('#accounts').dataTable( {
		"bJQueryUI": true,
		"sPaginationType": "full_numbers"
	} );
    $( "#sales_calender_date" ).datepicker({dateFormat: 'dd/mm/yy'})
  });

var editCustomerAccounts = function(customer_account_id) {
	$.ajax({
		url : '/customer_account/edit/'+ customer_account_id,
		type : 'PUT',
		success : function(data) {
			populateEditForm(data.resp);
		}
	});
};

var populateEditForm = function(resp) {
	var scope = $(".ngControllerClass").scope();
	scope.$apply(function() {
	    scope.averageRate = resp.rate;
	    scope.vehicleKg = resp.vehicle_kg;
	    scope.feedAmount = resp.feed_amount;
	    scope.paidAmount = resp.amount;
	    scope.shedKg = resp.shed_kg;
	    scope.averageRate = resp.rate;
	    scope.noOfBoxes = resp.vehicle_boxes;
	    scope.calculateAmount();
	});
	updateUI(resp.id);
};

var updateUI = function(sales_customer_account_id) {
	$('.addButtonSpan').html("<button class='updateButton' onClick='updateSales();'>UPDATE</button>");
	$('#sales_customer_account_id').val(sales_customer_account_id);
};

var updateSales = function() {
	var customer_account_id = $('#sales_customer_account_id').val();
  $.ajax({
		url : '/customer_account/update/'+ customer_account_id,
		type : 'PUT',
		data: $('.calculation_class').serialize(),
		success : function(data) {
			console.log(data);
		}
	});
};



