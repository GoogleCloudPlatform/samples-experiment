// Copyright 2023 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// [START functions_cloudevent_firebase_remote_config]
const functions = require('@google-cloud/functions-framework');

/**
 * Cloud Event Function triggered by a change to a Firebase Remote Config value.
 *
 * @param {object} event The Cloud Functions event.
 */
functions.cloudEvent('helloRemoteConfig', event => {
  console.log(`Update type: ${event.data.updateType}`);
  console.log(`Origin: ${event.data.updateOrigin}`);
  console.log(`Version: ${event.data.versionNumber}`);
});
// [END functions_cloudevent_firebase_remote_config]
