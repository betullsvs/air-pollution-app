package org.example.airpollution.client;


public interface IHttpRequestExecutor
{
    <T> T executeGetRequest(String url, Class<T> resultClass);
}
