function formatDate(matchDate, startTime) {
    const month = String(matchDate.month).padStart(2, '0');
    const day = String(matchDate.day).padStart(2, '0');
    const hour = String(startTime.hour).padStart(2, '0');
    const minute = String(startTime.minute).padStart(2, '0');

    return month + '/' + day + ' ' + hour + ':' + minute;
}