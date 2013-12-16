var hajisApp = angular.module('hajisApp', []);


hajisApp.controller('calculationCtrl', function ($scope, $http) {
	$scope.calculateAmount = function() {
		$http.get('/user_details').success(function(data) {
			$scope.userEmail = data.email
		});
		$scope.result = ($scope.noOfBoxes*$scope.averageRate);
	};
});
