package org.example.airpollution.controller;

import lombok.RequiredArgsConstructor;
import org.example.airpollution.PollutionDto.AirQualityResponse;
import org.example.airpollution.dto.AirPollutionRequestDto;
import org.example.airpollution.dto.LocationRequestDto;
import org.example.airpollution.dto.QueueRequestPollutionRecordDto;
import org.example.airpollution.model.City;
import org.example.airpollution.service.ICityService;
import org.springframework.security.access.annotation.Secured;
import org.springframework.web.bind.annotation.*;

import java.sql.Timestamp;
import java.time.*;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

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

    @PostMapping("/location")
    public AirQualityResponse returnPollutionByLocation(@RequestBody LocationRequestDto locationRequestDto )
    {
        QueueRequestPollutionRecordDto dto = new QueueRequestPollutionRecordDto();

        dto.setLon(locationRequestDto.getLon());
        dto.setLat(locationRequestDto.getLat());



        LocalDateTime localDateTime = LocalDateTime.now();
        /*System.out.println("--------------");
        System.out.println(localDateTime);*/
        ZoneId zoneId = ZoneId.systemDefault();
        ZonedDateTime zonedDateTime = localDateTime.atZone(zoneId);


        dto.setEndDate(zonedDateTime.toInstant().getEpochSecond());
        dto.setStartDate(zonedDateTime.toInstant().getEpochSecond() - 3600);

        //System.out.println(dto.getEndDate()+" "+dto.getStartDate());


        AirQualityResponse airQualityResponse = cityService.getAirQuality(dto);

        return  airQualityResponse;
    }

    @GetMapping("/populer-cities")
    public Map<String, AirQualityResponse> getPopularCitiesData() {

        return cityService.getCityAirData(); // Cache'teki veriyi döndür
    }




}
