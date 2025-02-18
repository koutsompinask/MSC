package com.msc.project.service;

import com.msc.project.model.User;
import com.msc.project.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepo;
    
    @Autowired
    private JWTService jwtService;
    
    @Autowired
    AuthenticationManager authManager;

    private BCryptPasswordEncoder encoder = new BCryptPasswordEncoder(12);
    
    public User register(User user){
    	user.setPassword(encoder.encode(user.getPassword()));
        return userRepo.save(user);
    }
    
    public String verify(User user) {
    	Authentication auth = authManager.authenticate(new UsernamePasswordAuthenticationToken(user.getUsername(), user.getPassword()));
		return auth.isAuthenticated() ? jwtService.generateToken(user) : "failure";
    }
}
