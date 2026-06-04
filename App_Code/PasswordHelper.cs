using System;
using System.Security.Cryptography;

public static class PasswordHelper
{
    private const int SaltSize = 16; // 128 bit
    private const int HashSize = 32; // 256 bit
    private const int Iterations = 100000; // PBKDF2 iterations

    public static void CreateHash(string password, out string base64Hash, out string base64Salt)
    {
        if (password == null) throw new ArgumentNullException("password");

        byte[] salt = new byte[SaltSize];
        using (var rng = RandomNumberGenerator.Create())
        {
            rng.GetBytes(salt);
        }

        // Use the constructor available in older .NET Frameworks (HMACSHA1-based PBKDF2)
        using (var pbkdf2 = new Rfc2898DeriveBytes(password, salt, Iterations))
        {
            byte[] hash = pbkdf2.GetBytes(HashSize);
            base64Hash = Convert.ToBase64String(hash);
            base64Salt = Convert.ToBase64String(salt);
        }
    }

    public static bool Verify(string password, string base64Salt, string base64Hash)
    {
        if (password == null) return false;
        if (string.IsNullOrEmpty(base64Salt) || string.IsNullOrEmpty(base64Hash)) return false;

        byte[] salt;
        byte[] expectedHash;
        try
        {
            salt = Convert.FromBase64String(base64Salt);
            expectedHash = Convert.FromBase64String(base64Hash);
        }
        catch
        {
            return false;
        }

        using (var pbkdf2 = new Rfc2898DeriveBytes(password, salt, Iterations))
        {
            byte[] actualHash = pbkdf2.GetBytes(expectedHash.Length);
            return FixedTimeEquals(actualHash, expectedHash);
        }
    }

    private static bool FixedTimeEquals(byte[] a, byte[] b)
    {
        if (a == null || b == null) return false;
        if (a.Length != b.Length) return false;
        int diff = 0;
        for (int i = 0; i < a.Length; i++)
        {
            diff |= a[i] ^ b[i];
        }
        return diff == 0;
    }
}
