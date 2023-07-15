import { useNavigate } from 'react-router-dom';
import { useSetters } from '../../store';
import Login from '../login';

const Signout: React.FC = () => {
    const setLoggedIn = useSetters((setter) => setter.setLoggedIn);

    const navigate = useNavigate();

    setLoggedIn(false);

    navigate('/login');

    return <Login />;
};

export default Signout;
