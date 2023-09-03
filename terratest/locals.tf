locals {
  storageaccounts = {
    storage1 = {
      storage_name              = "tfinttestepm20230901"
      containers = [
        {
          name = "images"
        },
        {
          name = "reports"
        }
      ]
      queues = [
        {
          name = "hello"
        },
        {
          name = "foo"
        },
        {
          name = "bar"
        }
      ]
    }
  }
}