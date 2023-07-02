package handler

import (
	"fmt"
	"io/ioutil"
	"net/http"
	"net/http/httptest"
	"strings"
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestGetDataHandler(t *testing.T) {
	req := httptest.NewRequest(http.MethodGet, "/", nil)
	w := httptest.NewRecorder()

	GetDataHandler(w, req)
	res := w.Result()
	defer res.Body.Close()

	data, err := ioutil.ReadAll(res.Body)
	assert.NoError(t, err)

	expected := fmt.Sprintf(`{"message":"%s"}`, message)
	assert.Equal(t, expected, strings.TrimSpace(string(data)))
}
