working notes

### 6.0.0 rearchitecture

1. removed RUM artifacts
2. removed Profiles
3. moved sampling decision from Event constructor to function calling Span constructor.
4. [API BREAKING] changed API signature of Span
    - 3rd argument is settings object returned by getTraceSettings()
5. [API BREAKING] changed API signature of Event
    - 3rd argument is metadata to use for the event creation.
    - 4th argument is whether to edge back to the metadata or not. (might be able to avoid this).
6. stringToMetadata() consider error if opID is all zeros (call lower level bindings fn to avoid)
    - takes check out of probes/http.js
7. packages with probe naming considerations (and their tests)
    - director
    - express
    - koa-resource-router
    - koa-route
    - koa-router
    - restify
8. moved KV pairs out of event and into event.kv https://chromium.googlesource.com/external/github.com/v8/v8.wiki/+/60dc23b22b18adc6a8902bd9693e386a3748040a/Design-Elements.md
9. stubbed new function bindings.Context.getTraceSetting() for use by entry/root spans.
10. added XgetTraceSettings() to appoptics-bindings/napi-branch. will become replacement for all entry/root spans.
11. [API BREAKING] change signature of span builder function in startOrContinueTrace, instrument, runInstrument, instrumentHttp. This impacts many tests.
12. move all decision/metadata generation logic into bindings.Context.getTraceSettings(). (this is implemented in index.js until there is a production tested oboe ready to go with the API in it. when that's ready the code will start using the oboe facility and the javascript implementation can be removed.)
13. modified span builder function return value's finalize function: spanInfo.finalize(span, previousSpan)
14. allow clearing of messages to be checked when testing.
15. don't store KV pairs if not sampling
16. fix koa-router probe bugs, add tests
17. make APPOPTICS_LOG_SETTING variable work in preference to DEBUG; clean up log levels. use `debug-custom` package.
18. warn if not loaded first (if production)
19. fix wrong oboe version reported
20. fix existsSync tests for node > 10.15.0 (again, thanks node)
21. warn if disabled by config
22. make noop custom tests work again
23. don't send init message when disabled
24. don't enable patching when disabled
25. move addon skeleton to addon-essentials.js
26. remove ao.sample(), add @typedef for TraceSettings (getTraceSettings() return value)
27. [API BREAKING] removed ao.sampleSource, global sample source. replaced by settings.source. settings returned by getTraceSettings().
28. [API BREAKING] removed ao.sampleMode. use ao.traceMode()
29. [deprecated] traceMode 'always' and 'never'; use 'enabled' and 'disabled'
30. [API BREAKING] removed sugary mode detectors, e.g., ao.always. use ao.traceMode === 'enabled' or ao.traceMode === 'disabled'
31. use native WeakMap replacing 'es6-weak-map' package.

### 6.3.0

1. delete requestStore.topSpan on exit topSpan.
2. Fix reversed API docs.
3. aws-sdk fixes and tests.
4. log unsampled task IDs don't match at debug level.
5. make task IDs don't match message more clear.
6. log insertion: winston, pino, morgan, bunyan
7. log insertion tests
8. add async-dump file (devDependency) consider wtfnode.
9. set cfg to service key used, not the one specified.


### next up

move api out of index and into api

back from vacation - configure and build oboe
