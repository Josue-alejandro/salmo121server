const sortByName = (array) => {
    return array.sort((a, b) => a.name.localeCompare(b.name));
}

const formatDate = (dateString) => {
    const date = new Date(dateString);
    const day = date.getDate();
    const month = date.getMonth() + 1; // Los meses en JavaScript son de 0 a 11
    const year = date.getFullYear();
    return `${day}/${month}/${year}`;
};

module.exports = {
    sortByName,
    formatDate
}