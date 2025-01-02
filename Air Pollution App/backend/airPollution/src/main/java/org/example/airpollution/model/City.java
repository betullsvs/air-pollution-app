package org.example.airpollution.model;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class City {

    private Long id;

    private String name;

    private Float lat;

    private Float lon;

    private String country;
}
