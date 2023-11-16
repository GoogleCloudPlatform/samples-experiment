# Copyright 2016 Google, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import uuid

from google.cloud import storage
import google.cloud.exceptions
import pytest

import storage_move_file



@pytest.fixture(scope="module")
def test_bucket():
    """Yields a bucket that is deleted after the test completes."""
    bucket = None
    while bucket is None or bucket.exists():
        bucket_name = f"storage-snippets-test-{uuid.uuid4()}"
        bucket = storage.Client().bucket(bucket_name)
    bucket.create()
    yield bucket
    bucket.delete(force=True)


@pytest.fixture
def test_blob(test_bucket):
    """Yields a blob that is deleted after the test completes."""
    bucket = test_bucket
    blob = bucket.blob(f"storage_snippets_test_sigil-{uuid.uuid4()}")
    blob.upload_from_string("Hello, is it me you're looking for?")
    yield blob


@pytest.fixture
def test_bucket_create():
    """Yields a bucket object that is deleted after the test completes."""
    bucket = None
    while bucket is None or bucket.exists():
        bucket_name = f"storage-snippets-test-{uuid.uuid4()}"
        bucket = storage.Client().bucket(bucket_name)
    yield bucket
    bucket.delete(force=True)


def test_move_blob(test_bucket_create, test_blob):
    bucket = test_blob.bucket
    storage.Client().create_bucket(test_bucket_create)

    try:
        test_bucket_create.delete_blob("test_move_blob")
    except google.cloud.exceptions.NotFound:
        print(f"test_move_blob not found in bucket {test_bucket_create.name}")

    storage_move_file.move_blob(
        bucket.name,
        test_blob.name,
        test_bucket_create.name,
        "test_move_blob",
    )

    assert test_bucket_create.get_blob("test_move_blob") is not None
    assert bucket.get_blob(test_blob.name) is None
