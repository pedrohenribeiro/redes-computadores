import axios from 'axios';

const api = axios.create({
    baseURL: 'http://69.62.92.128:4444'
});

export default api;