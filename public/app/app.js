var hajisApp = angular.module('hajisApp', []);


hajisApp.controller('calculationCtrl', function ($scope, $http) {
	$scope.calculateAmount = function() {
		$scope.result = ((((parseFloat($scope.shedKg) + parseFloat($scope.vehicleKg))*parseFloat($scope.averageRate)) + parseFloat($scope.feedAmount)) - parseFloat($scope.paidAmount));
	};

	$scope.updateSalesToServer = function() {
		$http({
			url: '/customer_amount/calculate',
			method: 'POST',
			data: $('.calculation_class').serialize(),
			headers: {'Content-type': 'application/x-www-form-urlencoded; charset=UTF-8'}
		}).success(function(data) {
			console.log(data);
		});
	};

	$scope.updateExistingSalesToServer = function() {
		console.log($scope);
	};
});
