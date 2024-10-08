import time

from django.utils.deprecation import MiddlewareMixin
from django.conf import settings


class StatsMiddleware(MiddlewareMixin):
    def process_request(self, request):
        """Store the start time when the request comes in."""
        request.start_time = time.time()

    def process_response(self, request, response):
        """Calculate and output the page generation duration."""
        # Get the start time from the request and calculate how long
        # the response took.
        duration = time.time() - request.start_time

        # Add the header.
        response["X-Page-Generation-Duration-ms"] = int(duration * 1000)
        return response


class EnvironmentHeaderMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        response = self.get_response(request)
        if getattr(settings, "ENVIRONMENT", "").upper() == "DEV":
            response['X-Environment'] = 'dev'

        return response
