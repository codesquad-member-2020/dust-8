package com.codesquad.dust08.data;

import com.fasterxml.jackson.annotation.JsonInclude;

@JsonInclude(JsonInclude.Include.NON_NULL)
public class ResponseResult {
    private Boolean valid;
    private String errorMessage;
    private Object result;

    public ResponseResult(boolean valid, String errorMessage) {
        this.valid = valid;
        this.errorMessage = errorMessage;
    }

    public ResponseResult(Object resultData) {
        result = resultData;
    }

    public Boolean getValid() {
        return valid;
    }

    public String getErrorMessage() {
        return errorMessage;
    }

    public Object getResult() {
        return result;
    }
}
