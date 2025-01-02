package org.example.airpollution.security;

import lombok.extern.slf4j.Slf4j;
import org.example.airpollution.util.SecurityUtils;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.annotation.web.configurers.HeadersConfigurer;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.provisioning.InMemoryUserDetailsManager;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
@EnableMethodSecurity(securedEnabled = true)
@Slf4j
public class SecurityConfig
{
    @Value("user1,user2")
    public String SECURE_KEY_TOKEN;

    @Value("admin1")
    public String ADMIN_KEY_TOKEN;

    @Bean
    public static PasswordEncoder passwordEncoder()
    {
        return new BCryptPasswordEncoder();
    }

    @Bean
    SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception
    {
        http.csrf(AbstractHttpConfigurer::disable).authorizeHttpRequests((authorize) -> {
                    authorize.anyRequest()
                            .authenticated();
                }).httpBasic(Customizer.withDefaults())
                .headers(headers -> headers.frameOptions(HeadersConfigurer.FrameOptionsConfig::disable));

        return http.build();
    }

    @Bean
    public UserDetailsService userDetailsService()
    {
        log.info("Configuring authentication manager");

        InMemoryUserDetailsManager manager = new InMemoryUserDetailsManager();

        if (SECURE_KEY_TOKEN != null)
        {
            String[] keys = SECURE_KEY_TOKEN.split(",");
            if (keys.length > 1)
            {
                UserDetails user1 = User.builder().username(keys[0])
                                                  .password(passwordEncoder().encode("samet"))
                                                  .roles(SecurityUtils.USER)
                                                  .build();

                UserDetails user2 = User.builder().username(keys[1])
                                                  .password(passwordEncoder().encode("tarik"))
                                                  .roles(SecurityUtils.USER)
                                                  .build();

                manager.createUser(user1);
                manager.createUser(user2);
            }
        }
        else
        {
            log.warn("Received null Secure Key Token!");
        }

        if (ADMIN_KEY_TOKEN != null)
        {
            UserDetails admin = User.builder().username(ADMIN_KEY_TOKEN)
                                              .password(passwordEncoder().encode("betul"))
                                              .roles(SecurityUtils.ADMIN)
                                              .build();

            manager.createUser(admin);
        }
        else
        {
            log.warn("Received null Administrative Key Token-1!");
        }

        return manager;
    }
}
