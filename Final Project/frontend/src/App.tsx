import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import './App.css';
import Navbar from './components/Navbar';
import Login from './components/Login';
import Home from './components/Home';
import LinkPage from './components/LinkPage';

function App() {
  return (
    <Router>
      <Navbar />
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/link" element={<LinkPage />} />
        <Route path="/login" element={<Login text="hello"/>} />
      </Routes>
    </Router>
  );
}

export default App;
