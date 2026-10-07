function searchPostAddress() {
    new daum.Postcode({
        oncomplete: function(data) {
            $('#address').val(data.roadAddress);
            $('#addressDetail').val(data.buildingName);

            var geocoder = new kakao.maps.services.Geocoder();

            geocoder.addressSearch(data.roadAddress, function(result, status) {
                if (status === kakao.maps.services.Status.OK) {
                    $('#lat').val(result[0].y);
                    $('#lng').val(result[0].x);
                }
            });
        }
    }).open();
}