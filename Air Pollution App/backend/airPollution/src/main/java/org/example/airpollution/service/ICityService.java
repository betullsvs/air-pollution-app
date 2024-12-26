package org.example.airpollution.service;

import org.example.airpollution.PollutionDto.AirQualityResponse;
import org.example.airpollution.dto.AirPollutionRequestDto;
import org.example.airpollution.dto.QueueRequestPollutionRecordDto;
import org.example.airpollution.model.City;

import java.util.List;

public interface ICityService {

    City getCityDetailFromApi(AirPollutionRequestDto airPollutionRequestDto);

    AirQualityResponse getAirQuality(QueueRequestPollutionRecordDto queueRequestPollutionRecordDto);


}
