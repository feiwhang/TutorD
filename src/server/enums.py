from enum import Enum


class Role(Enum):
    STUDENT = 'student'
    TUTOR = 'tutor'
    ADMIN = 'admin'

class VerificationStatus(Enum):
    AWAITING = 'awaiting'
    VERIFIED = 'verified'
    UNVERIFIED = 'unverified'