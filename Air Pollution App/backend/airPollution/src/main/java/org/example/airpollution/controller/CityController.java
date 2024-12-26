package org.example.airpollution.controller;

import lombok.RequiredArgsConstructor;
import org.example.airpollution.PollutionDto.AirQualityResponse;
import org.example.airpollution.dto.AirPollutionRequestDto;
import org.example.airpollution.dto.LocationRequestDto;
import org.example.airpollution.dto.QueueRequestPollutionRecordDto;
import org.example.airpollution.model.City;
import org.example.airpollution.service.ICityService;
import org.springframework.security.access.annotation.Secured;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.sql.Timestamp;
import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("api/airPollution")
@RequiredArgsConstructor
public class CityController {

    private final ICityService cityService;


    @PostMapping("/haurly")
    public AirQualityResponse returnPollutionRecordData(@RequestBody AirPollutionRequestDto airPollutionRequestDto)
    {

        QueueRequestPollutionRecordDto dto = new QueueRequestPollutionRecordDto();



            City city = cityService.getCityDetailFromApi(airPollutionRequestDto);


            dto.setLon(city.getLon());
            dto.setLat(city.getLat());
            dto.setEndDate(airPollutionRequestDto.getEndDate().atStartOfDay(ZoneId.systemDefault())
                    .toInstant()
                    .getEpochSecond());

            dto.setStartDate(airPollutionRequestDto.getStartDate().atStartOfDay(ZoneId.systemDefault())
                    .toInstant()
                    .getEpochSecond());


            AirQualityResponse airQualityResponse = cityService.getAirQuality(dto);


            return airQualityResponse;
    }





}
