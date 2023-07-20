from enum import Enum


class Role(Enum):
    STUDENT = 'student'
    TUTOR = 'tutor'
    ADMIN = 'admin'

class VerificationStatus(Enum):
    PENDING = 'pending'
    VERIFIED = 'verified'
    UNVERIFIED = 'unverified'