function FormatDate(matchDate, startTime) {
	const year = String(matchDate.year);
    const month = String(matchDate.month).padStart(2, '0');
    const day = String(matchDate.day).padStart(2, '0');
    const hour = String(startTime.hour).padStart(2, '0');
    const minute = String(startTime.minute).padStart(2, '0');
    
    const date = new Date(matchDate.year, matchDate.month - 1, matchDate.day);
    const dayName = GetDayName(date);
    return year + ' ' + month + '/' + day + ' (' + dayName + ') ' + hour + ':' + minute;
}
function GetDayName(date){
	const days = ['일', '월', '화', '수', '목', '금', '토'];
	const dayName = days[date.getDay()];
	return dayName;
	
}