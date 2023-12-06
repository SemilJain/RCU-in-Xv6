#include "types.h"

struct ReaderWriterLock {
    volatile uint64 readers;
    volatile int writer;
  };


  //All lock acq and free operations require that the lock state not be acquired/free
  // by this thread before the call, undefined behavior if this is not the case
  // The benchmark does not test this precondition.

  //init the lock and any associated resources
  void rw_lock_init(struct ReaderWriterLock *rwlock);

  //called by reader thread to acquire the lock
  //stall on the lock, should guarantee eventual progress
  //thread_id is the CPU ID of the calling thread - for CADE, this is between 0-7
  //may not be necessary for your implementation but this value is passed to the lock by the benchmark.
  void read_lock(struct ReaderWriterLock *rwlock, uint8 thread_id);

  //unlock a reader thread that has acquired the lock
  void read_unlock(struct ReaderWriterLock *rwlock, uint8 thread_id);

  //acquire a write lock
  //stall until lock is acquired - guarantee eventual progress.
  void write_lock(struct ReaderWriterLock *rwlock);

  //free an acquired write lock
  void write_unlock(struct ReaderWriterLock *rwlock);
