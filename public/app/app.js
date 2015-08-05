var hajisApp = angular.module('hajisApp', []);


hajisApp.controller('calculationCtrl', function ($scope, $http) {
	$scope.calculateAmount = function() {
		$scope.calculated_amnt = ((((parseFloat($scope.shedKg) + parseFloat($scope.vehicleKg))*parseFloat($scope.averageRate)) + parseFloat($scope.feedAmount)));
		$scope.result = ((((parseFloat($scope.shedKg) + parseFloat($scope.vehicleKg))*parseFloat($scope.averageRate)) + parseFloat($scope.feedAmount)) - parseFloat($scope.paidAmount));
	};

	$scope.updateSalesToServer = function() {
		var form = $('.calculation_class');

		if(form.valid()) {
			$http({
				url: '/customer_amount/calculate',
				method: 'POST',
				data: form.serialize(),
				headers: {
					'Content-type': 'application/x-www-form-urlencoded; charset=UTF-8'
				}
			}).success(function(data) {
				$('#accounts').DataTable().ajax.reload();
			});
		};
	};
});
