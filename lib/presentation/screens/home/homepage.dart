import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          children: [
            // Header Section
            _buildHeader(),

            // Search Bar
            _buildSearchBar(),

            // Main Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),

                    // Welcome Message
                    _buildWelcomeMessage(),

                    const SizedBox(height: 24),

                    // Outfit Inspiration Gallery
                    _buildOutfitGallery(),

                    const SizedBox(height: 32),

                    // Recommended Tailors
                    _buildRecommendedTailors(),

                    const SizedBox(height: 32),

                    // Featured Fabric Vendors
                    _buildFeaturedVendors(),

                    const SizedBox(height: 32),

                    // Active Orders
                    _buildActiveOrders(),

                    const SizedBox(height: 32),

                    // Saved Tailors
                    _buildSavedTailors(),

                    const SizedBox(height: 32),

                    // Upcoming Appointments
                    _buildUpcomingAppointments(),

                    const SizedBox(height: 32),

                    // Recent Activities
                    _buildRecentActivities(),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFA54600),
            const Color(0xFFA54600).withOpacity(0.8),
          ],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.white.withOpacity(0.2),
            child: const Icon(Icons.person, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'StitchSuit',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Nunito Sans',
                  ),
                ),
                Text(
                  'Premium Tailoring Services',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    fontFamily: 'Nunito Sans',
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.notifications_outlined,
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search for tailors, styles, or fabrics...',
          hintStyle: TextStyle(
            color: Colors.grey[400],
            fontFamily: 'Nunito Sans',
          ),
          prefixIcon: Icon(Icons.search, color: const Color(0xFFA54600)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeMessage() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFA54600).withOpacity(0.1),
            const Color(0xFFA54600).withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFA54600),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.waving_hand, color: Colors.white, size: 24),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello David 👋',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2D3748),
                    fontFamily: 'Nunito Sans',
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Ready to create your perfect suit?',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF718096),
                    fontFamily: 'Nunito Sans',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOutfitGallery() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Outfit Inspiration',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D3748),
            fontFamily: 'Nunito Sans',
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildOutfitCard('assets/images/outfit1.jpg', 'Classic Suit'),
              _buildOutfitCard('assets/images/outfit2.jpg', 'Casual Blazer'),
              _buildOutfitCard('assets/images/outfit3.jpg', 'Wedding Tuxedo'),
              _buildOutfitCard('assets/images/outfit4.jpg', 'Business Casual'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOutfitCard(String imagePath, String title) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFFA54600).withOpacity(0.3),
                    const Color(0xFFA54600).withOpacity(0.1),
                  ],
                ),
              ),
              child: const Center(
                child: Icon(Icons.image, size: 40, color: Color(0xFFA54600)),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                  ),
                ),
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Nunito Sans',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendedTailors() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recommended Tailors',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D3748),
            fontFamily: 'Nunito Sans',
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildTailorCard('Ahmed Hassan', '4.9 ★', 'Expert Suit Maker'),
              _buildTailorCard('Maria Santos', '4.8 ★', 'Wedding Specialist'),
              _buildTailorCard('John Smith', '4.7 ★', 'Casual Wear Expert'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTailorCard(String name, String rating, String specialty) {
    return Container(
      width: 200,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: const Color(0xFFA54600).withOpacity(0.1),
                child: Text(
                  name[0],
                  style: const TextStyle(
                    color: Color(0xFFA54600),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Nunito Sans',
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D3748),
                        fontFamily: 'Nunito Sans',
                      ),
                    ),
                    Text(
                      rating,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFFA54600),
                        fontFamily: 'Nunito Sans',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            specialty,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF718096),
              fontFamily: 'Nunito Sans',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedVendors() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Featured Fabric Vendors',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D3748),
            fontFamily: 'Nunito Sans',
          ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.2,
          children: [
            _buildVendorCard('Silk Paradise', 'Premium Silk'),
            _buildVendorCard('Cotton Co.', 'Organic Cotton'),
            _buildVendorCard('Wool Masters', 'Fine Wool'),
            _buildVendorCard('Linen Hub', 'Pure Linen'),
          ],
        ),
      ],
    );
  }

  Widget _buildVendorCard(String name, String category) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFA54600).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.store,
                color: Color(0xFFA54600),
                size: 24,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2D3748),
                fontFamily: 'Nunito Sans',
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              category,
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF718096),
                fontFamily: 'Nunito Sans',
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveOrders() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Active Orders',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D3748),
            fontFamily: 'Nunito Sans',
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFA54600).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.schedule,
                      color: Color(0xFFA54600),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Classic Navy Suit',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2D3748),
                            fontFamily: 'Nunito Sans',
                          ),
                        ),
                        Text(
                          'Ahmed Hassan • Est. 5 days',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF718096),
                            fontFamily: 'Nunito Sans',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Progress',
                        style: TextStyle(
                          fontSize: 12,
                          color: Color(0xFF718096),
                          fontFamily: 'Nunito Sans',
                        ),
                      ),
                      Text(
                        '60%',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFA54600),
                          fontFamily: 'Nunito Sans',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: 0.6,
                    backgroundColor: Colors.grey[200],
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFFA54600),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSavedTailors() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Saved Tailors',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D3748),
            fontFamily: 'Nunito Sans',
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 80,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildSavedTailorItem('Sarah Wilson', '4.9'),
              _buildSavedTailorItem('Mike Johnson', '4.8'),
              _buildSavedTailorItem('Lisa Chen', '4.7'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSavedTailorItem(String name, String rating) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: const Color(0xFFA54600).withOpacity(0.1),
            child: Text(
              name[0],
              style: const TextStyle(
                color: Color(0xFFA54600),
                fontWeight: FontWeight.bold,
                fontSize: 12,
                fontFamily: 'Nunito Sans',
              ),
            ),
          ),
          const SizedBox(width: 8),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D3748),
                  fontFamily: 'Nunito Sans',
                ),
              ),
              Text(
                '$rating ★',
                style: const TextStyle(
                  fontSize: 10,
                  color: Color(0xFFA54600),
                  fontFamily: 'Nunito Sans',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingAppointments() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Upcoming Appointments',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D3748),
            fontFamily: 'Nunito Sans',
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFA54600).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.calendar_today,
                  color: Color(0xFFA54600),
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Fitting Session',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2D3748),
                        fontFamily: 'Nunito Sans',
                      ),
                    ),
                    Text(
                      'Tomorrow, 2:00 PM • Ahmed Hassan',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF718096),
                        fontFamily: 'Nunito Sans',
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFA54600).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Remind',
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0xFFA54600),
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Nunito Sans',
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRecentActivities() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Activities',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2D3748),
            fontFamily: 'Nunito Sans',
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildActivityItem(
                Icons.shopping_bag,
                'Order placed for Classic Suit',
                '2 hours ago',
              ),
              const Divider(height: 24),
              _buildActivityItem(
                Icons.star,
                'Rated Ahmed Hassan 5 stars',
                '1 day ago',
              ),
              const Divider(height: 24),
              _buildActivityItem(
                Icons.favorite,
                'Saved Maria Santos to favorites',
                '2 days ago',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActivityItem(IconData icon, String title, String time) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFA54600).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: const Color(0xFFA54600), size: 16),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF2D3748),
                  fontFamily: 'Nunito Sans',
                ),
              ),
              Text(
                time,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF718096),
                  fontFamily: 'Nunito Sans',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home, 'Home', true),
              _buildNavItem(Icons.calendar_today, 'Bookings', false),
              _buildNavItem(Icons.style, 'Styles', false),
              _buildNavItem(Icons.chat_bubble_outline, 'Chats', false),
              _buildNavItem(Icons.person_outline, 'Profile', false),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isActive ? const Color(0xFFA54600) : Colors.grey[400],
          size: 24,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: isActive ? const Color(0xFFA54600) : Colors.grey[400],
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            fontFamily: 'Nunito Sans',
          ),
        ),
      ],
    );
  }
}
